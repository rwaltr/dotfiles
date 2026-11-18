/**
 * Subscription first, OpenRouter as the safety net.
 *
 * Registers `rwaltrpi/<id>` for models that a subscription already pays for: the
 * OpenCode Go tier directly, and the Claude Code models through the in-cluster
 * agentgateway. A request goes to the subscription; when it fails and Pi retries
 * it, the retry goes to the OpenRouter model instead, and the rest of that turn
 * stays there.
 *
 * Requires OPENCODE_API_KEY, AGENTGATEWAY_API_KEY and OPENROUTER_API_KEY.
 */

import type { ExtensionAPI, ModelRouteRequest } from "@earendil-works/pi-coding-agent";

const FALLBACK = "openrouter";

/** Routed id -> the subscription provider that serves it, and its OpenRouter stand-in. */
const MODELS: Record<string, { provider: string; fallback: string }> = {
	// OpenCode Go.
	"deepseek-v4.1-flash": { provider: "opencode-go", fallback: "deepseek/deepseek-v4.1-flash" },
	"deepseek-v4-pro": { provider: "opencode-go", fallback: "deepseek/deepseek-v4-pro" },
	"kimi-k3": { provider: "opencode-go", fallback: "moonshotai/kimi-k3" },
	"glm-5.3": { provider: "opencode-go", fallback: "z-ai/glm-5.3" },
	// Claude Code, through agentgateway's cliproxyapi aliases.
	"claude-sonnet-5-5": { provider: "agentgateway", fallback: "anthropic/claude-sonnet-5.5" },
	"claude-opus-5-5": { provider: "agentgateway", fallback: "anthropic/claude-opus-5.5" },
	"claude-haiku-5-5": { provider: "agentgateway", fallback: "anthropic/claude-haiku-5.5" },
};

export default function (pi: ExtensionAPI) {
	for (const [id, target] of Object.entries(MODELS)) {
		pi.registerVirtualModel({
			provider: "rwaltrpi",
			id,
			name: id,
			thinkingLevels: ["off", "minimal", "low", "medium", "high", "xhigh", "max"],
			route(request: ModelRouteRequest, ctx) {
				// A new user turn starts on the subscription; tool follow-ups and retried
				// requests keep the model that already answered this turn.
				const keep = request.reason !== "user" && request.reason !== "direct" && !request.failed && request.previous;
				if (keep && (keep.model.provider === target.provider || keep.model.provider === FALLBACK)) {
					return { model: keep.model, thinkingLevel: keep.thinkingLevel ?? request.thinkingLevel };
				}
				const pick = request.failed
					? { provider: FALLBACK, id: target.fallback }
					: { provider: target.provider, id };
				const model = ctx.modelRegistry.find(pick.provider, pick.id);
				if (!model) throw new Error(`Model ${pick.provider}/${pick.id} is not in the catalog`);
				return { model, thinkingLevel: request.thinkingLevel };
			},
		});
	}
}

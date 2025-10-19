function fish_greeting
    if status is-interactive
        # === Fun Quotes ===
        set quotes \
            "Let's make something crash today (intentionally)." \
            "Another day, another deployment." \
            "Remember: prod is a revenue generating lab" \
            "The cluster watches." \
            "Good morning, root cause detective." \
            "Brace yourself, logs are coming." \
            "Be the grep you want to see in the world." \
            "Sudo make it so." \
            "Running on caffeine and YAML." \
            "Today's forecast: 80% chance of timeouts." \
            "Let’s ship it and pray." \
            "Your code works… until it doesn’t." \
            "kubectl delete stress --all" \
            "If it compiles, it ships." \
            "Testing in production: the ultimate confidence move." \
            "Remember: YAML doesn’t love you back." \
            "Merge conflicts build character." \
            "If you’re not logging, you’re guessing." \
            "git push --force — because I like to live dangerously." \
            "The cloud is just someone else’s bash history." \
            "Code reviews: emotional damage edition." \
            "May your containers be stateless and your logs verbose." \
            "grep > therapy" \
            "sudo rm -rf impostor_syndrome" \
            "Your CI pipeline doesn’t care about your feelings." \
            "Today’s goal: fewer segfaults, more self-respect." \
            "Production is down, but morale is up!" \
            "Semicolons are optional, consequences aren’t." \
            "Monitoring says it’s fine. That’s the scary part." \
            "Deploying on a Friday — bold strategy, Cotton." \
            "That’s not a bug, that’s a race condition with personality." \
            "This pod is unschedulable, just like my weekend plans." \
            "You had me at ‘it works on my machine.’" \
            "Containerized chaos, delivered daily." \
            "return 0  # manifesting success" \
            "In logs we trust." \
            "Live, laugh, lint." \
            "Brace yourself, cronjobs are coming." \
            "You either die a dev, or live long enough to become ops." \
            "Lets just rewrite it in rust." \
            "Just once, I want kubectl to say ‘nice job.’"

        # === Pick a Random One ===
        set random_index (math (random) % (count $quotes) + 1)
        set random_quote $quotes[$random_index]

        # === Host + Date ===
        set host (hostname)
        set current_date (date "+%A, %b %d %H:%M")

        # === Print Greeting ===
        echo "👋  Howdy $USER — $current_date"
        echo "💻  Host: $host"
        echo "💬  $random_quote"
    end
end

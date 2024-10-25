import openai
import os
from dotenv import load_dotenv
import git
import sys

# Load API key from the .env file
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

def get_code_from_gpt(prompt):
    """Generate code using GPT-4 or GPT-3.5-turbo."""
    try:
        response = openai.ChatCompletion.create(
            model="gpt-4-turbo",  # Use "gpt-3.5-turbo" if you don't have access to "gpt-4-turbo"
            messages=[
                {"role": "system", "content": "You are a helpful coding assistant."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.7  # Adjusts creativity level
        )
        return response['choices'][0]['message']['content']
    except Exception as e:
        print(f"An error occurred: {e}")
        return None

def commit_and_push_changes(repo_path, commit_message):
    """Commit and push changes to the GitHub repository."""
    try:
        repo = git.Repo(repo_path)
        repo.git.add(A=True)  # Stages all changes
        repo.index.commit(commit_message)
        origin = repo.remote(name='origin')
        origin.push()
        print("Changes committed and pushed to GitHub successfully!")
    except Exception as e:
        print(f"Failed to commit and push changes: {e}")

def main():
    # Define your prompt
    prompt = "Create a SwiftUI view called 'LoginView' with email and password fields."
    print("Generating code...")
    generated_code = get_code_from_gpt(prompt)

    if generated_code:
        # Define the file path
        file_path = os.path.join(os.getcwd(), "LoginView.swift")
        
        # Save the generated code to a file
        with open(file_path, "w") as f:
            f.write(generated_code)
        print("Code generated and saved to LoginView.swift")

        # Commit and push changes
        commit_message = "Add LoginView.swift generated by GPT-4"
        commit_and_push_changes(os.getcwd(), commit_message)
    else:
        print("Failed to generate code.")

if __name__ == "__main__":
    main()

//const copyButtonLabel = "Copy Code";
const copyButtonLabel = "\u29C9 Copy";
// use a class selector if available
let blocks = document.querySelectorAll("pre");

blocks.forEach((block) => {
  // only add button if browser supports Clipboard API
  var hasCodeBlock = block.querySelector("code") != null;
  if (hasCodeBlock) {
      if (navigator.clipboard) {
        let button = document.createElement("button");

        button.innerText = copyButtonLabel;
        block.appendChild(button);

        button.addEventListener("click", async () => {
          await copyCode(block, button);
        });
      }
  }
});
// !Here we assume each "pre" block contains an inner "code" block.
async function copyCode(block, button) {
  let code = block.querySelector("code");
  let text = code.innerText;

  await navigator.clipboard.writeText(text);

  // visual feedback that task is completed
  button.innerText = "\u29C9 Copied";

  setTimeout(() => {
    button.innerText = copyButtonLabel;
  }, 700);
}
function mountFlash() {

window.flash = {}
flash.mount = (partial) => {
let wrapper = document.querySelector('.flash-wrapper')
wrapper.innerHTML = partial
setTimeout(() => {
  wrapper.innerHTML = ""
}, 3000)
 console.log("qdfjilqsdfjldfj")
}
}
mountFlash()

export default mountFlash
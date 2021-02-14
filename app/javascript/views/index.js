const requireModule = require.context("./"); //extract vue files inside modules folder
const modules = {};
requireModule.keys().forEach(fileName => {
  const moduleName = fileName.replace(/(\.\/|\.vue|\.js)/g, ""); //
  if(moduleName !== 'index'){
    modules[moduleName] = requireModule(fileName).default;
  }
});
export default modules;

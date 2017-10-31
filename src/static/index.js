import './styles/main.scss'
import Elm from '../renderer/Renderer'

// Inject Elm
Elm.Renderer.embed(document.getElementById('main'))

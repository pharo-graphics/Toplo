Trait {
	#name : #TToMouseHandler,
	#instVars : [
		'mouseEventListener'
	],
	#category : 'Toplo-Core'
}

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> clickEvent: anEvent in: anElement [


]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> doubleClickEvent: anEvent in: anElement [


]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> leftClickEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> leftMouseDownEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> leftMouseUpEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> middleClickEvent: anEvent in: anElement [


]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> middleMouseDownEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> middleMouseUpEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> mouseDownEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> mouseEnterEvent: anEvent in: anElement [
]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> mouseLeaveEvent: anEvent in: anElement [

	
]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> mouseUpEvent: anEvent in: anElement [


]

{ #category : #'t - mouse handling - install/uninstall  hook' }
TToMouseHandler >> onInstalledMouseHandlingIn: anElement [

	mouseEventListener := ToDresserMouseEventListener new target: anElement; dresser: self; yourself.
	anElement addEventHandler: mouseEventListener
]

{ #category : #'t - mouse handling - install/uninstall  hook' }
TToMouseHandler >> onUninstalledMouseHandlingIn: anElement [

	anElement removeEventHandler: mouseEventListener.
	mouseEventListener := nil

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> otherClickEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> otherMouseDownEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> otherMouseUpEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> rightClickEvent: anEvent in: anElement [
]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> rightMouseDownEvent: anEvent in: anElement [

]

{ #category : #'t - mouse handling - events handling' }
TToMouseHandler >> rightMouseUpEvent: anEvent in: anElement [

]

Class {
	#name : #MyCircularMenuItem,
	#superclass : #ToButton,
	#category : #'Toplo-Widget-Menu-NotUsed'
}

{ #category : #ressources }
MyCircularMenuItem class >> menuItemSvg [

	^ '<svg width="76" height="75" viewBox="0 0 76 75" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M75.5131 7.11758C51.1962 -2.3576 24.3273 -2.373 0 7.07436L27.1569 74.1689C34.0636 71.9446 41.4704 71.9398 48.3799 74.1551L75.5131 7.11758Z" fill="black"/>
</svg>
'
]

{ #category : #initialization }
MyCircularMenuItem >> initialize [ 

	super initialize.
	self zIndex: 1
]

{ #category : #skin }
MyCircularMenuItem >> newRawSkin [ 

	^ MyCircularMenuItemSkin new
]

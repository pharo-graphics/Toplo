Class {
	#name : #ToInlineMenuWindowElement,
	#superclass : #ToCustomMenuItem,
	#traits : 'TToAnchoredWindowElement + TToMenuWindowModel',
	#classTraits : 'TToAnchoredWindowElement classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Inline'
}

{ #category : #'t - menu window model' }
ToInlineMenuWindowElement >> closeWindow [

	self close
]

{ #category : #'api - displaying' }
ToInlineMenuWindowElement >> dispatchClosedEvent [

	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"
	super dispatchClosedEvent.
	self element  dispatchEvent: self newClosedEvent.

]

{ #category : #testing }
ToInlineMenuWindowElement >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #initialization }
ToInlineMenuWindowElement >> initialize [ 

	super initialize.
	self addEventHandler: ToMenuWindowEventHandler new
]

{ #category : #'t - menu window model' }
ToInlineMenuWindowElement >> isInline [ 

	^ true
]

{ #category : #'t - menu window model' }
ToInlineMenuWindowElement >> isSubmenu [

	^ super isSubmenu
]

{ #category : #'t - menu window model' }
ToInlineMenuWindowElement >> isTopMenu [

	^ false
]

{ #category : #accessing }
ToInlineMenuWindowElement >> itemContainer [

	^ self element
]

{ #category : #accessing }
ToInlineMenuWindowElement >> itemList [

	^ self element itemList
]

{ #category : #accessing }
ToInlineMenuWindowElement >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToInlineMenuWindowElement >> menuWindow [

	^ self 
]

{ #category : #skin }
ToInlineMenuWindowElement >> newRawSkin [ 

	^ ToInlineMenuWindowSkin new
]

{ #category : #'t - inline window element - accessing' }
ToInlineMenuWindowElement >> root [ 

	^ self
]

{ #category : #'api - displaying' }
ToInlineMenuWindowElement >> toThemeInstalled [

	| lt |
	self element ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]

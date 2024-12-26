Class {
	#name : #ToInlineMenuWindowElement,
	#superclass : #ToCustomMenuItem,
	#traits : 'TToWindowElement',
	#classTraits : 'TToWindowElement classTrait',
	#category : #'Toplo-Widget-Menu-Basic'
}

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
	self fitContent 
]

{ #category : #accessing }
ToInlineMenuWindowElement >> itemContainer [

	^ self element
]

{ #category : #accessing }
ToInlineMenuWindowElement >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #accessing }
ToInlineMenuWindowElement >> menuWindow [

	^ self
]

{ #category : #'instance creation' }
ToInlineMenuWindowElement >> newRawSkin [ 

	^ ToInlineMenuWindowSkin new
]

{ #category : #layout }
ToInlineMenuWindowElement >> onMeasure: anExtentMeasurementSpec [

	| w measureAgain |
	super onMeasure: anExtentMeasurementSpec.
	w := 0.
	self popupWindowParentMenuDo: [ :pm |
		pm collectedNodesDo: [ :node | w := w max: node item knownMinWidth ] ].
	measureAgain := false.
	self popupWindowParentMenuDo: [ :pm |
		pm collectedNodesDo: [ :node |
			node item measuredWidth < w ifTrue: [ measureAgain := true ] ] ].
	measureAgain ifFalse: [ ^ self ].
	self measuredWidth < w ifFalse: [ ^ self ].
	self childrenDo: [ :child | child width: w ].
	self popupWindowParentMenuDo: [ :pm |
		pm collectedItemsDo: [ :item | item width: w ] ].
	anExtentMeasurementSpec widthSpec size: w.
	super onMeasure: anExtentMeasurementSpec
]

{ #category : #'api - displaying' }
ToInlineMenuWindowElement >> toThemeInstalled [

	| lt |
	self element ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]

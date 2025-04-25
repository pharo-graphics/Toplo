Class {
	#name : #ToMenuInlineWindowElement,
	#superclass : #ToCustomMenuItem,
	#traits : 'TToAnchoredWindowElement + TToMenuWindowModel',
	#classTraits : 'TToAnchoredWindowElement classTrait + TToMenuWindowModel classTrait',
	#category : #'Toplo-Widget-Menu-Window'
}

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> closeWindow [

	self close
]

{ #category : #'api - displaying' }
ToMenuInlineWindowElement >> dispatchClosedEvent [
	" need to dispatch also to the element holding the window
	so that the window manager can manage the window 
	(recall that the window manager is an event handler of the element)"

	super dispatchClosedEvent.
	self anchorElement dispatchEvent: self newClosedEvent
]

{ #category : #testing }
ToMenuInlineWindowElement >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #initialization }
ToMenuInlineWindowElement >> initialize [ 

	super initialize.
	self addEventHandler: ToMenuContainerEventHandler new
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> isInline [ 

	^ true
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> isSubmenu [

	^ super isSubmenu
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> isTopMenu [

	^ false
]

{ #category : #accessing }
ToMenuInlineWindowElement >> itemBar [

	^ self anchorElement itemBar
]

{ #category : #accessing }
ToMenuInlineWindowElement >> itemContainer [

	^ self element
]

{ #category : #accessing }
ToMenuInlineWindowElement >> itemList [

	self
		deprecated: 'Use itemBar instead'
		transformWith: '`@rcvr itemList' -> '`@rcvr itemBar'.

	^ self itemBar
]

{ #category : #accessing }
ToMenuInlineWindowElement >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToMenuInlineWindowElement >> menuWindow [

	^ self 
]

{ #category : #skin }
ToMenuInlineWindowElement >> newRawSkin [ 

	^ ToMenuInlineWindowSkin new
]

{ #category : #layout }
ToMenuInlineWindowElement >> onLayout: aBounds context: aBlElementBoundsUpdateContext [

	super onLayout: aBounds context: aBlElementBoundsUpdateContext.
	self checkLayoutStepOnLayout: aBounds context: aBlElementBoundsUpdateContext
]

{ #category : #layout }
ToMenuInlineWindowElement >> onMeasure: anExtentMeasurementSpec [

	super onMeasure: anExtentMeasurementSpec.
	self onMeasure: anExtentMeasurementSpec onEvent: self lastPopupEvent 
]

{ #category : #'t - inline window element - accessing' }
ToMenuInlineWindowElement >> root [ 

	^ self
]

{ #category : #'api - displaying' }
ToMenuInlineWindowElement >> toThemeInstalled [

	| lt |
	self anchorElement ifNotNil: [ :e |
		lt := e lookupTheme.
		self localTheme = lt ifFalse: [ self localTheme: lt ] ].
	super toThemeInstalled
]

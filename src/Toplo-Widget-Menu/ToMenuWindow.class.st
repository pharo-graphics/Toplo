Class {
	#name : 'ToMenuWindow',
	#superclass : 'ToAnchoredWindow',
	#instVars : [
		'openedSubmenuWindow'
	],
	#category : 'Toplo-Widget-Menu-Basic',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Basic'
}

{ #category : 'api - displaying' }
ToMenuWindow >> close [ 

	openedSubmenuWindow ifNotNil: [ :w | w close ].
	super close
]

{ #category : 'initialization' }
ToMenuWindow >> defaultBackground [

	^ Color white
]

{ #category : 'initialization' }
ToMenuWindow >> defaultBorder [

	^ BlBorder paint: Color lightGray width: 1
]

{ #category : 'accessing' }
ToMenuWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : 'testing' }
ToMenuWindow >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : 'accessing' }
ToMenuWindow >> itemHolder [

	^ self element
]

{ #category : 'accessing' }
ToMenuWindow >> items [

	^ self itemHolder ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : 't - menu window model' }
ToMenuWindow >> menuWindow [

	^ self
]

{ #category : 'accessing' }
ToMenuWindow >> openedSubmenuWindow [

	^ openedSubmenuWindow
]

{ #category : 'accessing' }
ToMenuWindow >> openedSubmenuWindow: aWindow [

	openedSubmenuWindow ifNotNil: [ openedSubmenuWindow close ].
	openedSubmenuWindow := aWindow.
]

{ #category : 'api - displaying' }
ToMenuWindow >> popupEvent: anEvent [

	self element isAttachedToSceneGraph ifFalse: [
		Error signal: 'Can''t popup a menu if the element is not attached to a space' ].
	
	self items ifEmpty: [ ^ self ].
	self requestSkin.
	self items do: [ :it |
		self root addChild: it.
		it requestSkin ].
	super popupEvent: anEvent
]

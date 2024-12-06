Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #accessing }
ToMenuWindow >> defaultElevation [

	^ BlRelativeElevation elevation: (SmallInteger maxVal - 400)
]

{ #category : #testing }
ToMenuWindow >> includes: anElement [

	self = anElement ifTrue: [ ^ true ].
	(self items anySatisfy: [ :e | e includes: anElement ]) ifTrue: [
		^ true ].
	^ false
]

{ #category : #accessing }
ToMenuWindow >> itemContainer [

	^ self element
]

{ #category : #accessing }
ToMenuWindow >> items [

	^ self itemContainer ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToMenuWindow >> menuWindow [

	^ self
]

{ #category : #skin }
ToMenuWindow >> newRawSkin [ 

	^ ToMenuWindowSkin new
]

{ #category : #'api - displaying' }
ToMenuWindow >> onPositionChangedToFitAnchorRootDo: aBlock [

	| p |
	p := self positionWithinAnchorRoot.
	p ~= self position ifTrue: [
		self position: p.
		self whenLayoutedDoOnce: aBlock.
		^ self ].
	super onPositionChangedToFitAnchorRootDo: aBlock
]

{ #category : #enumerating }
ToMenuWindow >> withAllSubwindowsDo: aBlock [

	self items do: [ :i | i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]

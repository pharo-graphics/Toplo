Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - displaying' }
ToMenuWindow >> correctedPositionWithinAnchorRoot [

	| t rect rootRect |
	rect := self bounds inSpace bounds asRectangle.
	rootRect := 0 @ 0 extent: self anchorRoot extent.
	t := rect amountToTranslateWithin: rootRect.
	^ super correctedPositionWithinAnchorRoot + t
]

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

{ #category : #enumerating }
ToMenuWindow >> withAllSubwindowsDo: aBlock [

	self items do: [ :i | i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]

Class {
	#name : #ToMenuWindow,
	#superclass : #ToPopupWindow,
	#category : #'Toplo-Widget-Menu-Basic'
}

{ #category : #'api - displaying' }
ToMenuWindow >> close [ 

	self items do: [ :it | it closeWindow ].
	super close
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

{ #category : #skin }
ToMenuWindow >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'padding-content-H')
			 vertical: (self valueOfTokenNamed: #'padding-content-V')).
	(self valueOfTokenNamed: #'animation-window-opening') value: self.
	self effect: (self valueOfTokenNamed: #'effect-window')
]

{ #category : #accessing }
ToMenuWindow >> itemHolder [

	^ self element
]

{ #category : #accessing }
ToMenuWindow >> items [

	^ self itemHolder ifNil: [ ^ #(  ) ] ifNotNil: [ :w | w items ]
]

{ #category : #'t - menu window model' }
ToMenuWindow >> menuWindow [

	^ self
]

{ #category : #enumerating }
ToMenuWindow >> withAllSubwindowsDo: aBlock [

	self items do: [ :i | i menuWindowDo: [ :w | w withAllSubwindowsDo: aBlock ] ].
	super withAllSubwindowsDo: aBlock
]

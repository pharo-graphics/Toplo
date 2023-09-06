Class {
	#name : #ToBoxLook,
	#superclass : #ToElementLook,
	#instVars : [
		'margin',
		'padding',
		'width',
		'height'
	],
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToBoxLook >> height [

	^ height
]

{ #category : #accessing }
ToBoxLook >> height: aValuable [

	height := aValuable
]

{ #category : #'event handling' }
ToBoxLook >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e |
		self height ifNotNil: [ e height: (self height value: e) ].
		self width ifNotNil: [ e width: (self width value: e) ].
		self margin ifNotNil: [ e margin: (self margin value: e) ].
		self padding ifNotNil: [ e padding: (self padding value: e) ] ]
]

{ #category : #accessing }
ToBoxLook >> margin [

	^ margin
]

{ #category : #accessing }
ToBoxLook >> margin: aValuable [

	margin := aValuable
]

{ #category : #accessing }
ToBoxLook >> padding [

	^ padding
]

{ #category : #accessing }
ToBoxLook >> padding: aValuable [

	padding := aValuable
]

{ #category : #accessing }
ToBoxLook >> width [

	^ width
]

{ #category : #accessing }
ToBoxLook >> width: aValuable [

	width := aValuable
]

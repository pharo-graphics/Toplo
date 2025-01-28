Trait {
	#name : #TToButtonOwner,
	#instVars : [
		'button'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - button holder' }
TToButtonOwner >> button [

	^ button
]

{ #category : #'t - button holder' }
TToButtonOwner >> button: aButton [

	self button = aButton ifTrue: [ ^ self ].
	button ifNotNil: [ button removeFromParent ].
	button := aButton.
	button ifNotNil: [
		self addChild: button at: 1.
		aButton constraintsDo: [ :c | c linear vertical alignCenter ].
		aButton hMatchParent ]
]

{ #category : #'t - button holder' }
TToButtonOwner >> buttonClass [

	^ ToGeneralButton
]

{ #category : #'t - button holder' }
TToButtonOwner >> buttonClickEventClass [

	^ BlMouseUpEvent
]

{ #category : #'t - button holder' }
TToButtonOwner >> clickEventClass [

	^ self button clickEventClass
]

{ #category : #'t - button holder' }
TToButtonOwner >> initializeAsButtonOwner [

	self button: self buttonClass new.
	self button takeFocusOnClick: false.
	self button clickEventClass: self buttonClickEventClass.
	self layout: self defaultLayout
]

{ #category : #'t - button holder' }
TToButtonOwner >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	self button whenClickedDo: aBlock
]

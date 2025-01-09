Trait {
	#name : #TToButtonHolder,
	#instVars : [
		'button'
	],
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #'t - button holder' }
TToButtonHolder >> button [

	^ button
]

{ #category : #'t - button holder' }
TToButtonHolder >> button: aButton [

	self button = aButton ifTrue: [ ^ self ].
	button ifNotNil: [ button removeFromParent ].
	button := aButton.
	button ifNotNil: [
		self addChild: button at: 1.
		aButton constraintsDo: [ :c | c linear vertical alignCenter ].
		aButton hMatchParent ]
]

{ #category : #'t - button holder' }
TToButtonHolder >> buttonClass [

	^ ToGeneralButton
]

{ #category : #'t - button holder' }
TToButtonHolder >> buttonClickEventClass [

	^ BlMouseUpEvent
]

{ #category : #'t - button holder' }
TToButtonHolder >> clickEventClass [

	^ self button clickEventClass
]

{ #category : #'t - button holder' }
TToButtonHolder >> initializeButtonHolder [

	self button: self buttonClass new.
	self button takeFocusOnClick: false.
	self button clickEventClass: self buttonClickEventClass.
	self layout: self defaultLayout
]

{ #category : #'t - button holder' }
TToButtonHolder >> whenClickedDo: aBlock [
	"Inform that the widget has been clicked."

	self button whenClickedDo: aBlock
]

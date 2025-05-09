Class {
	#name : #ToGradientShrinkFeedbackLayer,
	#superclass : #ToShrinkFeedbackLayer,
	#category : #'Toplo-Core-Overlay'
}

{ #category : #'instance creation' }
ToGradientShrinkFeedbackLayer >> newBackgroundRampWithColor: aColor [

	| dir |
	dir := self checkedOrientation isHorizontal
		       ifTrue: [ 1 @ 0 ]
		       ifFalse: [ 0 @ 1 ].
	^ (BlLinearGradientPaint direction: dir)
		  stops: {
				  (0 -> (aColor alpha: 0.0)).
				  (0.75 -> (aColor alpha: 0.0)).
				  (0.8 -> (aColor alpha: 0.60)).
				  (0.85 -> (aColor alpha: 0.70)).
				  (0.90 -> (aColor alpha: 0.80)).
				  (0.95 -> (aColor alpha: 0.95)).
				  (1 -> (aColor alpha: 1.0)) };
		  yourself
]

{ #category : #skin }
ToGradientShrinkFeedbackLayer >> newRawSkin [ 

	^ ToGradientShrinkFeedbackLayerSkin new
]

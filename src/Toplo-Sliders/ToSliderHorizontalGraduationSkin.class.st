Class {
	#name : #ToSliderHorizontalGraduationSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Sliders-Core'
}

{ #category : #'event handling' }
ToSliderHorizontalGraduationSkin >> installSkinEvent: anEvent [

	anEvent elementDo: [ :element |
			element height: 25.
			element clipChildren: false.
			element slider whenLayoutedDoOnce: [
				element width:
					element slider width - element slider sliderKnob width ].
			element constraintsDo: [ :c |
					c frame vertical alignCenter.
					c frame horizontal alignCenter ].
			element layout: BlFrameLayout new.
			element zIndex: 3.
			element preventMeAndChildrenMouseEvents
			"self installStepsSkin: element" ]
]

{ #category : #skin }
ToSliderHorizontalGraduationSkin >> installStepsSkin: anElement [

	| minValue maxValue valueDiff |
	minValue := anElement minValue.
	maxValue := anElement maxValue.
	valueDiff := maxValue - minValue.
	anElement removeChildren.
	minValue to: maxValue by: anElement stepValue do: [ :value |
			| element |
			element := ToElement new
				           background: Color black;
				           constraintsDo: [ :c |
						           c vertical matchParent.
						           c horizontal exact: 2.
						           c frame horizontal alignCenterAt:
								           value - minValue / valueDiff ].
			anElement addChild: element ]
]

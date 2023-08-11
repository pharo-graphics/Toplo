Class {
	#name : #ToRectShaping,
	#superclass : #ToControlShaping,
	#category : #'Toplo-Core-Theme'
}

{ #category : #hook }
ToRectShaping >> applyOn: anElement [

	anElement layout: BlLinearLayout new.
	anElement hFitContent.
	anElement spacingWidth: anElement toTheme paddingContentHorizontal / 2.
	anElement padding: (BlInsets
			 top: anElement toTheme paddingXS / 2
			 left: anElement toTheme paddingContentHorizontal
			 bottom: anElement toTheme paddingXS / 2
			 right: anElement toTheme paddingContentHorizontal).
]

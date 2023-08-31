Class {
	#name : #ToLabelDisabledType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #accessing }
ToLabelDisabledType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

Class {
	#name : #ToLabelDisabledType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToLabelDisabledType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

Class {
	#name : #ToLabelSuccessType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToLabelSuccessType >> textColorIn: anElement [

	^ anElement toTheme colorSuccess
]

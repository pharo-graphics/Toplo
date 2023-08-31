Class {
	#name : #ToLabelSuccessType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #accessing }
ToLabelSuccessType >> textColorIn: anElement [

	^ anElement toTheme colorSuccess
]

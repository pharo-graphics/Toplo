Class {
	#name : #ToLabelSuccessType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToLabelSuccessType >> textColorIn: anElement [

	^ anElement toTheme colorSuccess
]

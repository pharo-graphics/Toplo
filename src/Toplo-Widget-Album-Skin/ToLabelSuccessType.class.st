Class {
	#name : #ToLabelSuccessType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToLabelSuccessType >> textColorIn: anElement [

	^ anElement toTheme colorSuccess
]

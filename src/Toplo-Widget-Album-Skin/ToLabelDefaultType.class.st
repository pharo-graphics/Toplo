Class {
	#name : #ToLabelDefaultType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin'
}

{ #category : #accessing }
ToLabelDefaultType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

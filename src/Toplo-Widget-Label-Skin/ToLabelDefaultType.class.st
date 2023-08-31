Class {
	#name : #ToLabelDefaultType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skin'
}

{ #category : #accessing }
ToLabelDefaultType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

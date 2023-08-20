Class {
	#name : #ToLabelDefaultType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToLabelDefaultType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

Class {
	#name : #ToLabelDefaultType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToLabelDefaultType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

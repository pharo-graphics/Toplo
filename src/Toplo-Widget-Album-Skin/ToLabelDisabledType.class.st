Class {
	#name : #ToLabelDisabledType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Album-Skin-Label'
}

{ #category : #accessing }
ToLabelDisabledType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

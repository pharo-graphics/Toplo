Class {
	#name : #ToLabelDisabledType,
	#superclass : #ToLabelType,
	#category : #'Toplo-Widget-Label-Skins'
}

{ #category : #accessing }
ToLabelDisabledType >> textColorIn: anElement [

	^ anElement toTheme colorText
]

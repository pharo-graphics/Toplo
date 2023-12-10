Class {
	#name : 'ToStyleSheetThemeForTest',
	#superclass : 'ToStyleSheetTheme',
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'initialization' }
ToStyleSheetThemeForTest >> defaultElementStampsFor: anElement [ 

	^ { #element }
]

{ #category : 'styling' }
ToStyleSheetThemeForTest >> newStyleSheet [ 

	^ ToStyleSheetForTest new
]

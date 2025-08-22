Class {
	#name : #ToStyleSheetTheme,
	#superclass : #ToTheme,
	#traits : 'TToStyleSheetTheme + TToStyleRuleScripter + TToStyleRulesHolder',
	#classTraits : 'TToStyleSheetTheme classTrait + TToStyleRuleScripter classTrait + TToStyleRulesHolder classTrait',
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToStyleSheetTheme class >> canBeDefault [

	^ false
]

{ #category : #visiting }
ToStyleSheetTheme >> accept: aVisitor [

	aVisitor visitStyleSheetTheme: self.
]

{ #category : #initialization }
ToStyleSheetTheme >> initialize [ 

	super initialize.
	self initializeAsStyleSheetTheme 
]

{ #category : #accessing }
ToStyleSheetTheme >> newSkinFor: anElement [

	^ self newStyleSheetBasedSkinInstanceFor: anElement
]

{ #category : #'api - hooks' }
ToStyleSheetTheme >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement styleSheet: self styleSheet
]

{ #category : #'api - hooks' }
ToStyleSheetTheme >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	anElement styleSheet: nil
]

{ #category : #'t - stylesheet scripter' }
ToStyleSheetTheme >> skinEventListenerHolder [ 

	^ self styleSheet script
]

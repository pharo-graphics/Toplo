Class {
	#name : #ToEmptyStyleSheetThemeGenerated,
	#superclass : #ToStyleSheetTheme,
	#category : #'Toplo-Core-Theme'
}

{ #category : #'accessing - generated' }
ToEmptyStyleSheetThemeGenerated class >> defaultTokenProperties [
	"This method has been generated.

	By: YannLEGOFF
	2024-02-14 09:21:30"

	^ super defaultTokenProperties , {  }
]

{ #category : #'scripting - generated' }
ToEmptyStyleSheetThemeGenerated class >> edit [
  < script>
  ToThemeEditorPresenter new
     theme: self light;
     open
]

{ #category : #'initialization - generated' }
ToEmptyStyleSheetThemeGenerated >> initializeStyleRules [
  "This method has been generated.

	By: YannLEGOFF
	2024-02-14 09:21:30"
  
]

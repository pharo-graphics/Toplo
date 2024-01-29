Class {
	#name : #ToStyleSheetThemeSpecializationPresenter,
	#superclass : #ToThemeSpecializationPresenter,
	#instVars : [
		'styleSheetThemePresenter'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #layout }
ToStyleSheetThemeSpecializationPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: self styleSheetThemePresenter expand: true;
		  add: self makeHelpLegend expand: false;
		  yourself
]

{ #category : #initialization }
ToStyleSheetThemeSpecializationPresenter >> initializePresenters [

	styleSheetThemePresenter := ToStyleSheetThemeInspectorSpec new.
]

{ #category : #'as yet unclassified' }
ToStyleSheetThemeSpecializationPresenter >> makeHelpLegend [

	| iconSet |
	iconSet := ToStyleSheetThemeExtensionSpec new.
	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   add: iconSet skinAndStyleRuleIcon expand: false;
				   add: 'Selector is ok and rule is applied.';
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: iconSet selectorOkButNotSkin expand: false;
				   add: 'Selector is ok but rule is not applied.';
				   yourself);
		  add: (SpBoxLayout newHorizontal
				   add: iconSet selectorKo expand: false;
				   add: 'Selector is ko.';
				   yourself);
		  yourself
]

{ #category : #accessing }
ToStyleSheetThemeSpecializationPresenter >> skin: aToSkin [

	self styleSheetThemePresenter skin: aToSkin
]

{ #category : #accessing }
ToStyleSheetThemeSpecializationPresenter >> styleSheetThemePresenter [

	^ styleSheetThemePresenter
]

{ #category : #accessing }
ToStyleSheetThemeSpecializationPresenter >> theme: aToStyleSheetTheme [

	self styleSheetThemePresenter styleSheetTheme: aToStyleSheetTheme.
]

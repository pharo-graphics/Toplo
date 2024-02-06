Class {
	#name : #ToploPanelThemePresenter,
	#superclass : #ToploPanelPresenter,
	#instVars : [
		'classInput',
		'notebook',
		'panelProperties',
		'panelTokens',
		'panelStamps'
	],
	#category : #'Toplo-IDE-theme-editor-deprecated'
}

{ #category : #accessing }
ToploPanelThemePresenter >> classInput [

	^ classInput
]

{ #category : #initialization }
ToploPanelThemePresenter >> initializePresenters [

	super initializePresenters.
	classInput := SpTextInputFieldPresenter new.
	panelProperties := ToploPanelPropertiesSelectorPresenter new.
	panelTokens := ToploPanelTokensSelectorPresenter new.
	panelStamps := ToploPanelStampsSelectorPresenter new.
	notebook := SpNotebookPresenter new
		            addPage:
			            (SpNotebookPage
				             title: 'Properties'
				             provider: [ self panelProperties ]);
		            addPage:
			            (SpNotebookPage
				             title: 'Tokens'
				             provider: [ self panelTokens ]);
		            addPage:
			            (SpNotebookPage
				             title: 'Stamps'
				             provider: [ self panelStamps ]);
		            yourself.
	panelContent := SpBoxLayout newVertical
		                spacing: 4;
		                add: (SpBoxLayout newHorizontal
				                 spacing: 4;
				                 add: 'Class:' expand: false;
				                 add: self classInput expand: true;
				                 yourself)
		                expand: false;
		                add: self notebook expand: true;
		                yourself
]

{ #category : #accessing }
ToploPanelThemePresenter >> notebook [

	^ notebook
]

{ #category : #'as yet unclassified' }
ToploPanelThemePresenter >> panelName [

	^ 'Theme'
]

{ #category : #accessing }
ToploPanelThemePresenter >> panelProperties [

	^ panelProperties
]

{ #category : #accessing }
ToploPanelThemePresenter >> panelStamps [

	^ panelStamps
]

{ #category : #accessing }
ToploPanelThemePresenter >> panelTokens [

	^ panelTokens
]

{ #category : #accessing }
ToploPanelThemePresenter >> theme: aToTheme [

	self panelProperties theme: aToTheme.
	self panelTokens theme: aToTheme.
	self panelStamps theme: aToTheme.
	self classInput text: aToTheme class name
]

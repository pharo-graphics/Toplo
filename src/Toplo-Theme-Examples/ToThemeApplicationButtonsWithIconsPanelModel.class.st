Class {
	#name : #ToThemeApplicationButtonsWithIconsPanelModel,
	#superclass : #ToThemeApplicationLineAndStampsPanelModel,
	#category : #'Toplo-Theme-Examples'
}

{ #category : #accessing }
ToThemeApplicationButtonsWithIconsPanelModel >> allStampsVariation [

	^ { nil. #'small-sizing'. #'large-sizing'. #round . #'label-first'}
]

{ #category : #accessing }
ToThemeApplicationButtonsWithIconsPanelModel >> makeElements [

	| primaryButton defaultButton dashedButton textButton linkButton |
	primaryButton := (ToButton id: #buttonA)
		                 labelText: 'Primary Button';
		                 tooltipText: 'I''m a button';
		              iconImage: (self iconNamed: #home).
	primaryButton addStamp: #primary.

	defaultButton := (ToButton id: #buttonB)
		                 labelText: 'Default Button';
		                 tooltipText: 'I''m a button';
		              iconImage: (self iconNamed: #home).

	dashedButton := (ToButton id: #buttonC)
		                labelText: 'Dashed Button';
		                tooltipText: 'I''m a button';
		              iconImage: (self iconNamed: #home).
	dashedButton addStamp: #dashed.

	textButton := (ToButton id: #buttonD)
		              labelText: 'Text Button';
		              tooltipText: 'I''m a button';
		              iconImage: (self iconNamed: #home).
	textButton addStamp: #text.

	linkButton := (ToButton id: #buttonE)
		              labelText: 'Link Button';
		              tooltipText: 'I''m a button';
		              iconImage: (self iconNamed: #home).
	linkButton addStamp: #link.
	^ {
		  primaryButton.
		  defaultButton.
		  dashedButton.
		  textButton.
		  linkButton }
]

{ #category : #accessing }
ToThemeApplicationButtonsWithIconsPanelModel >> name [

	^ 'Buttons with icons'
]

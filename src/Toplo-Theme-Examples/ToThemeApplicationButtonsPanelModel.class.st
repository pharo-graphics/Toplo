Class {
	#name : #ToThemeApplicationButtonsPanelModel,
	#superclass : #ToThemeApplicationLineAndStampsPanelModel,
	#category : #'Toplo-Theme-Examples'
}

{ #category : #'as yet unclassified' }
ToThemeApplicationButtonsPanelModel >> allStampsVariation [

	^ { nil. #'small-sizing'. #'large-sizing'. #circle. #round }
]

{ #category : #accessing }
ToThemeApplicationButtonsPanelModel >> makeElements [

	| primaryButton defaultButton dashedButton textButton linkButton |
	primaryButton := (ToButton id: #buttonA)
		                 labelText: 'Primary Button';
		                 tooltipText: 'I''m a button'.
	primaryButton addStamp: #primary.

	defaultButton := (ToButton id: #buttonB)
		                 labelText: 'Default Button';
		                 tooltipText: 'I''m a button'.

	dashedButton := (ToButton id: #buttonC)
		                labelText: 'Dashed Button';
		                tooltipText: 'I''m a button'.
	dashedButton addStamp: #dashed.

	textButton := (ToButton id: #buttonD)
		              labelText: 'Text Button';
		              tooltipText: 'I''m a button'.
	textButton addStamp: #text.

	linkButton := (ToButton id: #buttonE)
		              labelText: 'Link Button';
		              tooltipText: 'I''m a button'.
	linkButton addStamp: #link.
	^ {
		  primaryButton.
		  defaultButton.
		  dashedButton.
		  textButton.
		  linkButton }
]

{ #category : #accessing }
ToThemeApplicationButtonsPanelModel >> name [

	^ 'Buttons'
]

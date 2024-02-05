Class {
	#name : #ToploPanelInsideEventEditorForNotNil,
	#superclass : #ToploPanelInsideEventEditorAbstract,
	#instVars : [
		'eventSelector',
		'actionRadio',
		'propertyRadio'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #initialization }
ToploPanelInsideEventEditorForNotNil >> actionRadio [

	^ actionRadio
]

{ #category : #initialization }
ToploPanelInsideEventEditorForNotNil >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 4;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: 'Type:' expand: false;
				   add: self actionRadio expand: false;
				   add: self propertyRadio expand: false;
				   yourself)
		  expand: false;
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: 'Event:' expand: false;
				   add: self eventSelector expand: true;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #initialization }
ToploPanelInsideEventEditorForNotNil >> eventSelector [

	^ eventSelector
]

{ #category : #initialization }
ToploPanelInsideEventEditorForNotNil >> initializePresenters [

	eventSelector := SpDropListPresenter new
		                 items:
			                 (ToElementLookEvent allSubclasses select: [ :each |
					                  each isAbstract not ]);
		                 yourself.
	actionRadio := SpRadioButtonPresenter new
		               label: 'action';
		               yourself.
	propertyRadio := SpRadioButtonPresenter new
		                 label: 'property writer';
		                 yourself.
	actionRadio associatedRadioButtons: {
			actionRadio.
			propertyRadio }
]

{ #category : #initialization }
ToploPanelInsideEventEditorForNotNil >> propertyRadio [

	^ propertyRadio
]

Class {
	#name : #ToploPanelWithButtonPresenter,
	#superclass : #ToploPanelPresenter,
	#instVars : [
		'buttonAdd',
		'buttonRemove'
	],
	#category : #'Toplo-IDE-theme-editor'
}

{ #category : #adding }
ToploPanelWithButtonPresenter >> addAction [

	^ [  ]
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> addHelp [

	^ 'Add to the current list.'
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> addIcon [

	^ self iconNamed: #smallAdd
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> addLabel [ 

	^ 'Add'
]

{ #category : #accessing }
ToploPanelWithButtonPresenter >> buttonAdd [

	^ buttonAdd
]

{ #category : #accessing }
ToploPanelWithButtonPresenter >> buttonRemove [

	^ buttonRemove
]

{ #category : #layout }
ToploPanelWithButtonPresenter >> defaultLayout [

	^ super defaultLayout
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: SpNullPresenter new;
				   add: self buttonAdd;
				add: SpNullPresenter new;
				   add: self buttonRemove;
				add: SpNullPresenter new;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : #initialization }
ToploPanelWithButtonPresenter >> initializePresenters [

	buttonAdd := SpButtonPresenter new
		             label: self addLabel;
		             icon: self addIcon;
		             action: self addAction;
		             help: self addHelp;
		             yourself.
	buttonRemove := SpButtonPresenter new
		                label: self removeLabel;
		                icon: self removeIcon;
		                action: self removeAction;
		                help: self removeHelp;
		                yourself.
	panelContent := SpNullPresenter new
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> removeAction [

	^ [  ]
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> removeHelp [

	^ 'Remove to the current list.'
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> removeIcon [

	^ self iconNamed: #smallCancel
]

{ #category : #adding }
ToploPanelWithButtonPresenter >> removeLabel [

	^ 'Remove'
]

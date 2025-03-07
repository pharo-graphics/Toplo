Class {
	#name : #ToThemeApplication,
	#superclass : #Object,
	#instVars : [
		'rootElement',
		'panelModels',
		'navigation',
		'stampButtons',
		'themeSelector',
		'currentPanel',
		'themeSelectorMenu',
		'selectedPanelModel'
	],
	#category : #'Toplo-Theme-Examples'
}

{ #category : #'as yet unclassified' }
ToThemeApplication >> applyThemeSelectorMenu [

	self currentPanel space ifNotNil: [ :s |
		s toTheme: self themeSelectorMenu selectedData value value ]
]

{ #category : #accessing }
ToThemeApplication >> currentPanel [

	^ currentPanel ifNil: [
		  currentPanel := (BlElement new
			                   margin: (BlInsets all: 8);
			                   constraintsDo: [ :c |
				                   c horizontal matchParent.
				                   c vertical fitContent ];
			                   yourself) asScrollableElement ]
]

{ #category : #initialization }
ToThemeApplication >> initialize [

	self initializeRootElement.
	self intializeStampButtons.
	self initializePanelModels.

	self initializeThemeSelector.
	self initializeNavigationPanel.

	self refreshThemeSelectorMenu.
	self applyThemeSelectorMenu.
	self layout
]

{ #category : #initialization }
ToThemeApplication >> initializeNavigationPanel [

	navigation := ToPane new
		              id: 'navigation';
		              background: Color blue;
		              vertical: true;
		              constraintsDo: [ :c |
			              c vertical matchParent.
			              c horizontal exact: 200 ];
		              localTheme: self navigationTheme;
		              padding: (BlInsets all: 8);
		              yourself.
	navigation layout cellSpacing: 4.
	navigation addChild: (ToLabel new text: 'Stamps').
	self stampButtons do: [ :button | navigation addChild: button ].
	navigation addChild: (ToLabel new text: 'Widgets').
	self panelModels do: [ :model |
		navigation addChild: model button.
		self selectedPanelModel: model.
		model button linkClickAction: [
			self currentPanel removeChildren.
			self currentPanel addChild: model panel ] ]
]

{ #category : #initialization }
ToThemeApplication >> initializePanelModels [

	panelModels := OrderedCollection new.
	panelModels add: ToThemeApplicationButtonsPanelModel new.
	panelModels add: ToThemeApplicationButtonsWithIconsPanelModel new.
	panelModels add: ToThemeApplicationCheckboxPanelModel new.
	panelModels add: ToThemeApplicationLabelPanelModel new.
	self selectedPanelModel: panelModels first.
	self currentPanel addChild: panelModels first panel
]

{ #category : #initialization }
ToThemeApplication >> initializeRootElement [

	rootElement := ToPane new
		               id: 'rootElement';
		               constraintsDo: [ :c |
			               c horizontal matchParent.
			               c vertical matchParent ];
		               background: Color gray;
		               yourself.

]

{ #category : #initialization }
ToThemeApplication >> initializeThemeSelector [

	themeSelector := ToPane new
		                 id: 'themeSelector';
		                 padding: (BlInsets all: 8);
		                 constraintsDo: [ :c |
			                 c horizontal matchParent.
			                 c vertical fitContent ];
		                 layout: BlLinearLayout new;
		                 localTheme: self navigationTheme;
		                 yourself.
	themeSelector layout cellSpacing: 16.
	
	themeSelectorMenu := ToChoiceMenu new
		                     constraintsDo: [ :c | c horizontal matchParent ];
		                     yourself.
	themeSelectorMenu dataToTextConverter: [ :assoc | assoc key ].
	themeSelector addChild: (ToButton new
			 labelText: 'refresh list';
			 constraintsDo: [ :c | c minWidth: 128 ];
			 linkClickAction: [ self refreshThemeSelectorMenu ];
			 yourself).
	themeSelector addChild: themeSelectorMenu.
	themeSelector addChild: (ToButton new
			 labelText: 'apply theme';
			 constraintsDo: [ :c | c minWidth: 128 ];
			 linkClickAction: [ self applyThemeSelectorMenu ];
			 yourself)
]

{ #category : #initialization }
ToThemeApplication >> intializeStampButtons [

	| group |
	stampButtons := OrderedCollection new.
	group := ToCheckableGroup new
		         withStrictCheckingStrategy;
		         yourself.
	{ #normal. #danger. #success. #warning } do: [ :stampText |
		| button |
		button := ToCheckbox new
			          labelText: stampText;
			          registerInGroup: group;
			          constraintsDo: [ :c | c horizontal matchParent ];
			          linkClickAction: [
				          self panelModels do: [ :each |
						          each applyStamp: stampText ] ];
			          yourself.
		stampButtons add: button ].
	stampButtons first check
]

{ #category : #accessing }
ToThemeApplication >> layout [

	self rootElement addChild: self navigation.
	self rootElement
		addChild: (ToPane new
				 vertical: true;
				
				 constraintsDo: [ :c |
					 c vertical matchParent.
					 c horizontal matchParent ];
				 addChild: self themeSelector;
				 addChild: self currentPanel;
				 yourself);
		yourself
]

{ #category : #accessing }
ToThemeApplication >> navigation [

	^ navigation
]

{ #category : #'as yet unclassified' }
ToThemeApplication >> navigationTheme [

	^ ToRawDarkTheme new
]

{ #category : #'instance creation' }
ToThemeApplication >> open [

	^ self rootElement openInNewSpace
]

{ #category : #accessing }
ToThemeApplication >> panelModels [

	^ panelModels
]

{ #category : #'as yet unclassified' }
ToThemeApplication >> refreshThemeSelectorMenu [

	| defaultThemes  |
	defaultThemes := {
		                 ('Raw Theme light' -> [ ToRawTheme new ]).
		                 ('Raw Theme dark' -> [ToRawDarkTheme new]).
		                 ('Bee Theme light' -> [ToBeeTheme new]).
		                 ('Bee Theme dark' -> [ToBeeDarkTheme new]) }.
	self themeSelectorMenu data removeAll.
	self themeSelectorMenu data addAll: defaultThemes.
	self themeSelectorMenu selectIndex: 1
]

{ #category : #'instance creation' }
ToThemeApplication >> rootElement [

	^ rootElement
]

{ #category : #initialization }
ToThemeApplication >> selectedPanelModel [

	^ selectedPanelModel
]

{ #category : #initialization }
ToThemeApplication >> selectedPanelModel: anObject [

	selectedPanelModel := anObject
]

{ #category : #accessing }
ToThemeApplication >> stampButtons [

	^ stampButtons
]

{ #category : #initialization }
ToThemeApplication >> themeSelector [

	^ themeSelector
]

{ #category : #initialization }
ToThemeApplication >> themeSelectorMenu [

	^ themeSelectorMenu
]

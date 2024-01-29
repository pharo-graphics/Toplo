Class {
	#name : #ToSkinThemeSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'labelSkin',
		'browseSkinButton',
		'inspectSkinButton',
		'complementView',
		'labelTheme',
		'browseThemeButton',
		'inspectThemeButton'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #accessing }
ToSkinThemeSpec >> browseSkinButton [

	^ browseSkinButton
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> browseThemeButton [

	^ browseThemeButton
]

{ #category : #accessing }
ToSkinThemeSpec >> complementView [

	^ complementView
]

{ #category : #accessing }
ToSkinThemeSpec >> complementView: aSpPresenter [

	complementView := aSpPresenter
]

{ #category : #layout }
ToSkinThemeSpec >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal spacing: 4; add:(SpBoxLayout newHorizontal
				   spacing: 4;
				   add: self labelTheme;
				   add: self browseThemeButton expand: false;
				   add: self inspectThemeButton expand: false;
				   yourself); add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: self labelSkin;
				   add: self browseSkinButton expand: false;
				   add: self inspectSkinButton expand: false;
				   yourself))
		  expand: false;
		  add: self complementView expand: true;
		  yourself
]

{ #category : #layout }
ToSkinThemeSpec >> element: aBlElement [

	aBlElement ifNil: [ ^ self noElementSelected ].
	aBlElement userData
		at: #skinManager
		ifPresent: [ :skinManager |
			skinManager installedSkin
				ifNil: [ self noInstalledSkin ]
				ifNotNil: [ :skin | self installedSkin: skin ] ]
		ifAbsent: [ self noSkinManager ].
	self installedTheme: aBlElement toTheme.
	self complementView element: aBlElement
]

{ #category : #accessing }
ToSkinThemeSpec >> initializePresenter [

	labelSkin := SpLabelPresenter new.
	labelTheme := SpLabelPresenter new.
	complementView := ToDefaultThemeExtensionSpec new.
	browseSkinButton := SpButtonPresenter new
		                    icon: (self iconNamed: #nautilus);
		                    label: 'Browse';
		                    help: 'Browse the skin';
		                    yourself.
	browseThemeButton := SpButtonPresenter new
		                     icon: (self iconNamed: #nautilus);
		                     label: 'Browse';
		                     help: 'Browse the skin';
		                     yourself.
	inspectSkinButton := SpButtonPresenter new
		                     icon: (self iconNamed: #smallInspectIt);
		                     label: 'Inspect';
		                     help: 'inspect the skin';
		                     yourself.
	inspectThemeButton := SpButtonPresenter new
		                      icon: (self iconNamed: #smallInspectIt);
		                      label: 'Inspect';
		                      help: 'inspect the skin';
		                      yourself
]

{ #category : #accessing }
ToSkinThemeSpec >> inspectSkinButton [

	^ inspectSkinButton
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> inspectThemeButton [
^ inspectThemeButton
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> installedSkin: aSkin [

	self labelSkin label: 'I have a ' , aSkin class name , '.'.
	self browseSkinButton enabled: true.
	self browseSkinButton action: [ aSkin browse ].
	self inspectSkinButton enabled: true.
	self inspectSkinButton action: [ aSkin inspect ].

	self complementView skin: aSkin
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> installedTheme: aTheme [

	self labelTheme label: 'I have a ' , aTheme printString , '.'.
	self browseThemeButton enabled: true.
	self browseThemeButton action: [ aTheme browse ].
	self inspectThemeButton enabled: true.
	self inspectThemeButton action: [ aTheme inspect ].

	self complementView theme: aTheme
]

{ #category : #accessing }
ToSkinThemeSpec >> labelSkin [

	^ labelSkin
]

{ #category : #accessing }
ToSkinThemeSpec >> labelTheme [

	^ labelTheme
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> noElementSelected [

	self labelSkin label: 'No element selected.'.
	self labelTheme label: 'No element selected.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false.
	self browseThemeButton enabled: false.
	self inspectThemeButton enabled: false
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> noInstalledSkin [

	self label label: 'I have no installed skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> noSkinManager [

	self labelSkin label: 'I have no skin manager, i cannot use any skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

Class {
	#name : #ToSkinWithSkinManagerPresenter,
	#superclass : #ToSkinPresenter,
	#instVars : [
		'labelSkin',
		'browseSkinButton',
		'inspectSkinButton',
		'labelTheme',
		'browseThemeButton',
		'inspectThemeButton',
		'themeSpecializationPresenter'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #accessing }
ToSkinWithSkinManagerPresenter >> browseSkinButton [

	^ browseSkinButton
]

{ #category : #accessing }
ToSkinWithSkinManagerPresenter >> browseThemeButton [

	^ browseThemeButton
]

{ #category : #accessing }
ToSkinWithSkinManagerPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: (SpBoxLayout newHorizontal
						    spacing: 4;
						    add: self labelTheme;
						    add: self browseThemeButton
						    withConstraints: [ :c | c width: 24 ];
						    add: self inspectThemeButton
						    withConstraints: [ :c | c width: 24 ];
						    yourself);
				   add: (SpBoxLayout newHorizontal
						    spacing: 4;
						    add: self labelSkin;
						    add: self browseSkinButton
						    withConstraints: [ :c | c width: 24 ];
						    add: self inspectSkinButton
						    withConstraints: [ :c | c width: 24 ];
						    yourself))
		  expand: false;
		  add: self themeSpecializationPresenter expand: true;
		  yourself
]

{ #category : #accessing }
ToSkinWithSkinManagerPresenter >> element: aBlElement [

	self installedTheme: aBlElement toTheme.
	aBlElement skinManager installedSkin
		ifNil: [ self noInstalledSkin ]
		ifNotNil: [ :skin | self installedSkin: skin ].
	self layout: self defaultLayout
]

{ #category : #'initialization - deprecated' }
ToSkinWithSkinManagerPresenter >> initializePresenter [

	labelSkin := SpLabelPresenter new.
	labelTheme := SpLabelPresenter new.
	themeSpecializationPresenter := SpNullPresenter new..
	browseSkinButton := SpButtonPresenter new
		                    icon: (self iconNamed: #nautilus);
		                    help: 'Browse the skin';
		                    yourself.
	browseThemeButton := SpButtonPresenter new
		                     icon: (self iconNamed: #nautilus);
		                     help: 'Browse the theme';
		                     yourself.
	inspectSkinButton := SpButtonPresenter new
		                     icon: (self iconNamed: #smallInspectIt);
		                     help: 'inspect the skin';
		                     yourself.
	inspectThemeButton := SpButtonPresenter new
		                      icon: (self iconNamed: #smallInspectIt);
		                      help: 'inspect the theme';
		                      yourself
]

{ #category : #'initialization - deprecated' }
ToSkinWithSkinManagerPresenter >> inspectSkinButton [

	^ inspectSkinButton
]

{ #category : #'initialization - deprecated' }
ToSkinWithSkinManagerPresenter >> inspectThemeButton [

	^ inspectThemeButton
]

{ #category : #'accessing - installed skin' }
ToSkinWithSkinManagerPresenter >> installedSkin: aSkin [

	self labelSkin label: 'I have a ' , aSkin class name , '.'.
	self browseSkinButton enabled: true.
	self browseSkinButton action: [ aSkin browse ].
	self inspectSkinButton enabled: true.
	self inspectSkinButton action: [ aSkin inspect ].

	self themeSpecializationPresenter skin: aSkin
]

{ #category : #'as yet unclassified' }
ToSkinWithSkinManagerPresenter >> installedTheme: aTheme [

	self labelTheme label: 'I have a ' , aTheme printString , '.'.
	self browseThemeButton enabled: true.
	self browseThemeButton action: [ aTheme browse ].
	self inspectThemeButton enabled: true.
	self inspectThemeButton action: [ aTheme inspect ].

	self themeSpecializationPresenter: aTheme specializationPresenter.
]

{ #category : #'initialization - deprecated' }
ToSkinWithSkinManagerPresenter >> labelSkin [

	^ labelSkin
]

{ #category : #'initialization - deprecated' }
ToSkinWithSkinManagerPresenter >> labelTheme [

	^ labelTheme
]

{ #category : #'as yet unclassified' }
ToSkinWithSkinManagerPresenter >> noInstalledSkin [

	self labelSkin label: 'I have no installed skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

{ #category : #'accessing - installed skin' }
ToSkinWithSkinManagerPresenter >> themeSpecializationPresenter [

	^ themeSpecializationPresenter
]

{ #category : #'accessing - installed skin' }
ToSkinWithSkinManagerPresenter >> themeSpecializationPresenter: aPresenter [

	themeSpecializationPresenter := aPresenter
]

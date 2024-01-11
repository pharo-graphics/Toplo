Class {
	#name : #ToSkinThemeSpec,
	#superclass : #SpPresenter,
	#instVars : [
		'label',
		'browseSkinButton',
		'inspectSkinButton',
		'complementView'
	],
	#category : #'Toplo-IDE-space-theme-inspector'
}

{ #category : #accessing }
ToSkinThemeSpec >> browseSkinButton [

	^ browseSkinButton
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
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: self label;
				   add: self browseSkinButton expand: false;
				   add: self inspectSkinButton expand: false;
				   yourself)
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
	self complementView element: aBlElement
]

{ #category : #accessing }
ToSkinThemeSpec >> initializePresenter [

	label := SpLabelPresenter new.
	complementView := ToDefaultThemeExtensionSpec new.
	browseSkinButton := SpButtonPresenter new
		                    icon: (self iconNamed: #nautilus);
		                    label: 'Browse';
		                    help: 'Browse the skin';
		                    yourself.
	inspectSkinButton := SpButtonPresenter new
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
ToSkinThemeSpec >> installedSkin: aSkin [
	
	self label label: 'I have a ' , aSkin class name , '.'.
	self browseSkinButton enabled: true.
	self browseSkinButton action: [ aSkin browse ].
	self inspectSkinButton enabled: true.
	self inspectSkinButton action: [ aSkin inspect ].
	
	self complementView skin: aSkin.
]

{ #category : #accessing }
ToSkinThemeSpec >> label [

	^ label
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> noElementSelected [

	self label label: 'No element selected.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> noInstalledSkin [

	self label label: 'I have no installed skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

{ #category : #'as yet unclassified' }
ToSkinThemeSpec >> noSkinManager [

	self label label: 'I have no skin manager, i cannot use any skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

Class {
	#name : #ToSpaceThemeSkinForElementSpec,
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
ToSpaceThemeSkinForElementSpec >> browseSkinButton [

	^ browseSkinButton
]

{ #category : #accessing }
ToSpaceThemeSkinForElementSpec >> complementView [

	^ complementView
]

{ #category : #accessing }
ToSpaceThemeSkinForElementSpec >> complementView: aSpPresenter [

	complementView := aSpPresenter
]

{ #category : #layout }
ToSpaceThemeSkinForElementSpec >> defaultLayout [

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
ToSpaceThemeSkinForElementSpec >> element: aBlElement [

	aBlElement ifNil: [ ^ self noElementSelected ].
	aBlElement userData 
		at: #skinManager
		ifPresent: [ :skinManager | skinManager installedSkin ifNil: [ self noInstalledSkin ] ifNotNil: [ :skin | self installedSkin: skin ] ]
		ifAbsent: [ self noSkinManager ]
]

{ #category : #accessing }
ToSpaceThemeSkinForElementSpec >> initializePresenter [

	label := SpLabelPresenter new.
	complementView := ToSpaceThemeSkinForElementComplementSpec new.
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
ToSpaceThemeSkinForElementSpec >> inspectSkinButton [

	^ inspectSkinButton
]

{ #category : #'as yet unclassified' }
ToSpaceThemeSkinForElementSpec >> installedSkin: aSkin [
	
	self label label: 'I have a ' , aSkin class name , '.'.
	self browseSkinButton enabled: true.
	self browseSkinButton action: [ aSkin browse ].
	self inspectSkinButton enabled: true.
	self inspectSkinButton action: [ aSkin inspect ].
	
	self complementView skin: aSkin.
]

{ #category : #accessing }
ToSpaceThemeSkinForElementSpec >> label [

	^ label
]

{ #category : #'as yet unclassified' }
ToSpaceThemeSkinForElementSpec >> noElementSelected [

	self label label: 'No element selected.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

{ #category : #'as yet unclassified' }
ToSpaceThemeSkinForElementSpec >> noInstalledSkin [

	self label label: 'I have no installed skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

{ #category : #'as yet unclassified' }
ToSpaceThemeSkinForElementSpec >> noSkinManager [

	self label label: 'I have no skin manager, i cannot use any skin.'.
	self browseSkinButton enabled: false.
	self inspectSkinButton enabled: false
]

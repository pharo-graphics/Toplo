Class {
	#name : #ToActionDresser,
	#superclass : #ToDresser,
	#instVars : [
		'installAction',
		'uninstallAction'
	],
	#category : 'Toplo-Core'
}

{ #category : #initialization }
ToActionDresser >> initialize [

	super initialize.
	installAction := [ :e | ].
	uninstallAction := [ :e | ].
]

{ #category : #accessing }
ToActionDresser >> installAction [

	^ installAction
]

{ #category : #accessing }
ToActionDresser >> installAction: aBlock [

	installAction := aBlock
]

{ #category : #'api - install/uninstall  hook' }
ToActionDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	self installAction cull: anElement cull: self cull: self

]

{ #category : #'api - install/uninstall  hook' }
ToActionDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	self uninstallAction cull: anElement


]

{ #category : #accessing }
ToActionDresser >> uninstallAction [

	^ uninstallAction
]

{ #category : #accessing }
ToActionDresser >> uninstallAction: aBlock [

	uninstallAction := aBlock
]

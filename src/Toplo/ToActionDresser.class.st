Class {
	#name : #ToActionDresser,
	#superclass : #ToDresser,
	#instVars : [
		'installAction',
		'uninstallAction'
	],
	#category : #'Toplo-Core'
}

{ #category : #initialization }
ToActionDresser >> initialize [ 

	super initialize.
	installAction := [ :element | ].
	uninstallAction := [ :element | ].
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
	installAction value: anElement
]

{ #category : #'api - install/uninstall  hook' }
ToActionDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.
	uninstallAction value: anElement
]

{ #category : #accessing }
ToActionDresser >> uninstallAction [

	^ uninstallAction
]

{ #category : #accessing }
ToActionDresser >> uninstallAction: aBlock [

	uninstallAction := aBlock
]

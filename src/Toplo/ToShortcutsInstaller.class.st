Class {
	#name : #ToShortcutsInstaller,
	#superclass : #Object,
	#instVars : [
		'shortcut',
		'eventTarget'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToShortcutsInstaller >> eventTarget [

	^ eventTarget
]

{ #category : #accessing }
ToShortcutsInstaller >> eventTarget: anEventTarget [

	eventTarget := anEventTarget
]

{ #category : #'installing - uninstalling' }
ToShortcutsInstaller >> install [

	self eventTarget addShortcut: self shortcut
]

{ #category : #accessing }
ToShortcutsInstaller >> shortcut [

	^ shortcut
]

{ #category : #accessing }
ToShortcutsInstaller >> shortcut: aShortcut [

	shortcut := aShortcut
]

{ #category : #'installing - uninstalling' }
ToShortcutsInstaller >> uninstall [

	self eventTarget addShortcut: self shortcut
]

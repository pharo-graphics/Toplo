Class {
	#name : #ToEditorShortcutsInstaller,
	#superclass : #ToShortcutsInstaller,
	#category : #'Toplo-Core'
}

{ #category : #'installing - uninstalling' }
ToEditorShortcutsInstaller >> install [

	self eventTarget addEditorShortcut: self shortcut
]

{ #category : #'installing - uninstalling' }
ToEditorShortcutsInstaller >> uninstall [

	self eventTarget removeEditorShortcut: self shortcut
]

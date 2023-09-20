Class {
	#name : 'Toplo',
	#superclass : 'Object',
	#category : 'Toplo-Core',
	#package : 'Toplo',
	#tag : 'Core'
}

{ #category : 'settings' }
Toplo class >> settingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #Toplo) 
		label: 'Toplo';
		description: 'Toplo settings';
		parent: #appearance
]

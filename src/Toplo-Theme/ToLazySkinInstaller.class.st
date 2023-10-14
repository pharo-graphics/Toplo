Class {
	#name : 'ToLazySkinInstaller',
	#superclass : 'ToAbstractSkinInstaller',
	#category : 'Toplo-Theme-Core',
	#package : 'Toplo-Theme',
	#tag : 'Core'
}

{ #category : 'accessing' }
ToLazySkinInstaller >> defaultSkinIn: anElement [

	^ anElement defaultSkin
]

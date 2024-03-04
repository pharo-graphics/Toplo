Class {
	#name : #ToInfiniteDataSourceCommandTypeFlags,
	#superclass : #BlInfiniteDataSourceCommandTypeFlags,
	#classVars : [
		'Add',
		'Move',
		'Other',
		'Remove',
		'Update'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #'accessing - flags' }
ToInfiniteDataSourceCommandTypeFlags class >> Add [
	"This method was automatically generated"
	^ Add value
]

{ #category : #'accessing - flags' }
ToInfiniteDataSourceCommandTypeFlags class >> Move [
	"This method was automatically generated"
	^ Move value
]

{ #category : #'accessing - flags' }
ToInfiniteDataSourceCommandTypeFlags class >> Other [
	"This method was automatically generated"
	^ Other value
]

{ #category : #'accessing - flags' }
ToInfiniteDataSourceCommandTypeFlags class >> Remove [
	"This method was automatically generated"
	^ Remove value
]

{ #category : #'accessing - flags' }
ToInfiniteDataSourceCommandTypeFlags class >> Update [
	"This method was automatically generated"
	^ Update value
]

{ #category : #'flags declaration' }
ToInfiniteDataSourceCommandTypeFlags class >> flagsDecl [
	"
	self rebuildFlagsAccessors
	"
	^ super flagsDecl, {
		#OTHER
	}
]

{ #category : #'flags - add' }
ToInfiniteDataSourceCommandTypeFlags >> addAdd [
	"This method was automatically generated"
	value := value | Add value
]

{ #category : #'flags - add' }
ToInfiniteDataSourceCommandTypeFlags >> addMove [
	"This method was automatically generated"
	value := value | Move value
]

{ #category : #'flags - add' }
ToInfiniteDataSourceCommandTypeFlags >> addOther [
	"This method was automatically generated"
	value := value | Other value
]

{ #category : #'flags - add' }
ToInfiniteDataSourceCommandTypeFlags >> addRemove [
	"This method was automatically generated"
	value := value | Remove value
]

{ #category : #'flags - add' }
ToInfiniteDataSourceCommandTypeFlags >> addUpdate [
	"This method was automatically generated"
	value := value | Update value
]

{ #category : #'flags - clear' }
ToInfiniteDataSourceCommandTypeFlags >> clearAdd [
	"This method was automatically generated"
	value := value & (Add value bitInvert)
]

{ #category : #'flags - clear' }
ToInfiniteDataSourceCommandTypeFlags >> clearMove [
	"This method was automatically generated"
	value := value & (Move value bitInvert)
]

{ #category : #'flags - clear' }
ToInfiniteDataSourceCommandTypeFlags >> clearOther [
	"This method was automatically generated"
	value := value & (Other value bitInvert)
]

{ #category : #'flags - clear' }
ToInfiniteDataSourceCommandTypeFlags >> clearRemove [
	"This method was automatically generated"
	value := value & (Remove value bitInvert)
]

{ #category : #'flags - clear' }
ToInfiniteDataSourceCommandTypeFlags >> clearUpdate [
	"This method was automatically generated"
	value := value & (Update value bitInvert)
]

{ #category : #'flags - testing' }
ToInfiniteDataSourceCommandTypeFlags >> hasAdd [
	"This method was automatically generated"
	^ (value & Add value) ~= 0
]

{ #category : #'flags - testing' }
ToInfiniteDataSourceCommandTypeFlags >> hasMove [
	"This method was automatically generated"
	^ (value & Move value) ~= 0
]

{ #category : #'flags - testing' }
ToInfiniteDataSourceCommandTypeFlags >> hasOther [
	"This method was automatically generated"
	^ (value & Other value) ~= 0
]

{ #category : #'flags - testing' }
ToInfiniteDataSourceCommandTypeFlags >> hasRemove [
	"This method was automatically generated"
	^ (value & Remove value) ~= 0
]

{ #category : #'flags - testing' }
ToInfiniteDataSourceCommandTypeFlags >> hasUpdate [
	"This method was automatically generated"
	^ (value & Update value) ~= 0
]

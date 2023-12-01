//
//  Copyright 2019 Mull Project
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#pragma once

#include "irm/ConstValues/ConstValueConstructor.h"
#include "irm/IRMutation.h"
#include <llvm/IR/Type.h>
#include <memory>

namespace irm {

class HalideReplacement : public IRMutation {
public:
  HalideReplacement(ConstValueConstructor *constConstructor, llvm::Type::TypeID returnTypeId);
  bool canMutate(llvm::Instruction *instruction) override;
  void mutate(llvm::Instruction *instruction) override;

private:
  std::unique_ptr<ConstValueConstructor> constConstructor;
  llvm::Type::TypeID returnTypeId;
};

class Halide_AddToSub : public HalideReplacement {
public:
  explicit Halide_AddToSub(int value)
      : HalideReplacement(new IntValueConstructor(value), llvm::Type::VoidTyID) {}
};

} // namespace irm

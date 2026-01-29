#ifndef __NULAT_Nulat__
#define __NULAT_Nulat__

#include <Config.hh>
#include <RAT/AnyParse.hh>
#include <RAT/ProcAllocator.hh>
#include <RAT/ProcBlockManager.hh>
#include <RAT/Rat.hh>

namespace NULAT {
class Nulat : public RAT::Rat {
public:
  Nulat(RAT::AnyParse *p, int argc, char **argv);
};
} // namespace NULAT

#endif // __NULAT_Nulat__
